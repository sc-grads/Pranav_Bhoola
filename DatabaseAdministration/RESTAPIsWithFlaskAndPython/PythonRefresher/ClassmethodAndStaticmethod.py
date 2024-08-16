class ClassTest:
    def instace_method(self):
        print(f"Called instance_method of {self}")

test = ClassTest()
test.instace_method()
ClassTest.instace_method(test)


class ClassTest:
    def instace_method(self):
        print(f"Called instance_method of {self}")

    @classmethod
    def class_method(cls):  
        print(f"Called class_method of {cls}")

