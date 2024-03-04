import socket
import signal
import sys

# 监听的地址和端口
HOST = '127.0.0.1'
PORT = 12345

# 定义信号处理函数
def signal_handler(sig, frame):
    print('\nExiting...')
    sys.exit(0)

# 设置信号处理程序
signal.signal(signal.SIGINT, signal_handler)
signal.signal(signal.SIGTERM, signal_handler)

# 创建TCP socket
with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as server_socket:
    # 设置socket选项，允许地址重用
    server_socket.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
    # 绑定地址和端口
    server_socket.bind((HOST, PORT))
    # 开始监听
    server_socket.listen(1)
    print(f"Listening on {HOST}:{PORT}...")

    try:
        while True:
            # 接受连接
            conn, addr = server_socket.accept()
            with conn:
                print(f"Connected by {addr}")

                # 打开/创建debug.log文件
                with open("debug.log", "a") as log_file:
                    while True:
                        data = conn.recv(1024)
                        if not data:
                            print(f"Connection closed by {addr}")
                            break
                        # 将收到的消息写入到控制台和日志文件中
                        msg = data.decode('utf-8')
                        print(msg)
                        log_file.write(msg)
                        log_file.flush()

    except KeyboardInterrupt:
        print('\nKeyboardInterrupt: Exiting...')
        sys.exit(0)