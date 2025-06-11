import multiprocessing
import time

def cpu_intensive_task():
    while True:
        result = 0
        result2 = 10**8
        for i in range(1000000):
            result += i
            result2 -= i

if __name__ == "__main__":
    print("PY - Starting load generator")
    time.sleep(20)

    num_processes = multiprocessing.cpu_count()
    processes = []

    for _ in range(num_processes):
        p = multiprocessing.Process(target=cpu_intensive_task)
        p.start()
        processes.append(p)

    for p in processes:
        p.join()

