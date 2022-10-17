#include <mpd/client.h>

#include <stdio.h>
#include <unistd.h>

#include <string>
#include <iostream>

#include <thread>
// TODO: use mutex
// #include <mutex>

// TODO: keep connection

std::string to_time(unsigned int s)
{
    unsigned int seconds = s % 60;
    unsigned int minutes = (s / 60) % 60;
    unsigned int hours = (s / 3600);

    std::string r;

    std::string minutes_string = std::to_string(minutes);
    std::string seconds_string = std::to_string(seconds);

    if (seconds_string.length() != 2) seconds_string = "0" + seconds_string;
    if (minutes_string.length() != 2) minutes_string = "0" + minutes_string;

    if (hours > 0) r += std::to_string(hours) + ":";
    r += minutes_string + ":" + seconds_string;

    return r;
}

void status()
{
    mpd_status* status = 0;
    mpd_song* song = 0;
    mpd_connection* conn = 0;

    while (1) {

        if (song)
            mpd_song_free(song);
        if (status)
            mpd_status_free(status);
        if (conn)
            mpd_connection_free(conn);

        conn = mpd_connection_new(0, 0, 1000);

        mpd_error error = mpd_connection_get_error(conn);

        if (error != MPD_ERROR_SUCCESS) {
            std::cout << "MPD OFFLINE" << std::endl;
            song = 0;
            status = 0;
            conn = 0;
            sleep(1);
            continue;
        }

        status = mpd_run_status(conn);
        mpd_state state = mpd_status_get_state(status);

        if (state == MPD_STATE_UNKNOWN) {
            sleep(1);
            continue;
        }

        std::string states;
        switch (state) {
        case MPD_STATE_PAUSE:
            states = "Paused";
            break;
        case MPD_STATE_PLAY:
            states = "Playing";
            break;
        default:
            states = "";
        }

        mpd_song* song = mpd_run_current_song(conn);

        if (!song) {
            sleep(1);
            continue;
        }

        const char* artist_s = mpd_song_get_tag(song, MPD_TAG_ARTIST, 0);
        const char* title_s = mpd_song_get_tag(song, MPD_TAG_TITLE, 0);
        const char* album_s = mpd_song_get_tag(song, MPD_TAG_ALBUM, 0);
        const char* uri_s = mpd_song_get_uri(song);

        std::string artist = artist_s ? artist_s : "";
        std::string title = title_s ? title_s : "";
        std::string album = album_s ? album_s : "";

        unsigned int time = mpd_status_get_elapsed_time(status);
        unsigned int ttime = mpd_status_get_total_time(status);

        std::string text;
        if (!title_s) {
            text = (uri_s) ? uri_s : " ";
        } else if (artist_s && title_s && album_s) {
            text = artist + " - " + title + " - " + album;
        } else if (artist_s && title_s) {
            text = artist + " - " + title;
        }

        std::cout << '[' << states << ' ' << to_time(time) << " - " << to_time(ttime) << ']'
                  << ' ' << text << std::endl;

        mpd_send_idle(conn);
        mpd_recv_idle(conn, false);
    }
}

void input()
{
    mpd_connection* conn = 0;

    while (1) {

        char c;
        std::cin >> c;

        if (conn)
            mpd_connection_free(conn);

        conn = mpd_connection_new(0, 0, 0);

        if (!conn) {
            sleep(1);
            continue;
        }

        switch (c) {
        case '1':
            mpd_run_previous(conn);
            break;
        case '2':
            mpd_run_toggle_pause(conn);
            break;
        case '3':
            mpd_run_next(conn);
            break;
        case '4':
            if (system("modstate Shift")) {
                mpd_run_seek_current(conn, 10, true);
            } else {
                mpd_run_change_volume(conn, 2);
            }
            break;
        case '5':
            if (system("modstate Shift")) {
                mpd_run_seek_current(conn, -10, true);
            } else {
                mpd_run_change_volume(conn, -2);
            }
            break;
        }
    }
}

int main()
{
    std::thread status_thread(status);
    std::thread input_thread(input);

    status_thread.join();
    input_thread.join();
}
