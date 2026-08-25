#include <csignal>
#include <chrono>
#include <iostream>
#include <thread>
#include <atomic>

static std::atomic_bool running{true};

static void on_signal(int) {
    running = false;
}

int main() {
    std::signal(SIGINT, on_signal);
    std::signal(SIGTERM, on_signal);

    std::cout << "myctrl started" << std::endl;

    while (running) {
        std::this_thread::sleep_for(std::chrono::seconds(5));
        std::cout << "myctrl alive" << std::endl;
    }

    std::cout << "myctrl stopped" << std::endl;
    return 0;
}
