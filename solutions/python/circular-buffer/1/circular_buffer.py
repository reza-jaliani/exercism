class BufferFullException(BufferError):
    """Exception raised when CircularBuffer is full."""
    def __init__(self, message):
        super().__init__(message)


class BufferEmptyException(BufferError):
    """Exception raised when CircularBuffer is empty."""
    def __init__(self, message):
        super().__init__(message)


class CircularBuffer:
    def __init__(self, capacity):
        self.capacity = capacity
        self.buffer = [None] * capacity
        self.read_idx = 0
        self.write_idx = 0
        self.size = 0

    def read(self):
        if self.size == 0:
            raise BufferEmptyException("Circular buffer is empty")

        value = self.buffer[self.read_idx]
        self.read_idx = (self.read_idx + 1) % self.capacity
        self.size -= 1
        return value

    def write(self, data):
        if self.size == self.capacity:
            raise BufferFullException("Circular buffer is full")

        self.buffer[self.write_idx] = data
        self.write_idx = (self.write_idx + 1) % self.capacity
        self.size += 1

    def overwrite(self, data):
        if self.size == self.capacity:
            self.buffer[self.write_idx] = data
            self.write_idx = (self.write_idx + 1) % self.capacity
            self.read_idx = (self.read_idx + 1) % self.capacity
        else:
            self.write(data)

    def clear(self):
        self.buffer = [None] * self.capacity
        self.read_idx = 0
        self.write_idx = 0
        self.size = 0
