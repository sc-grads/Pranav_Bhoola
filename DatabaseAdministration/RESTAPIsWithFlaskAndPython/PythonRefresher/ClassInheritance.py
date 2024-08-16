class Device:
    def __init__(self,name,connected_by):
        self.name = name
        self.connected_by = connected_by
        self.connected = True

    def __str__(self):
        return f"Device {self.name!r} ({self.connected_by})"
    
    def disconnect(self):
        self.connected = False
        print("Disconnected.")

class Printer(Device):
    def __init__(self,name,connected_by,capacity):
        super().__init__(name,connected_by)
        self.capacity = capacity
        self.remaining_page = capacity

    def __str__(self):
        return f"{super().__str__()}({self.remaining_page} pages remaining)"
    
    def print(self,page):
        if not self.connected:
            print("Your printer is not connected!")
            return
        print(f"Printing {page} pages.")
        self.remaining_page -= page


printer = Printer("Printer", "USB", 500)
printer.print(20)

print(printer)