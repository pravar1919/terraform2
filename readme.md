This is to go through the terraform terminolgies and other parameters like:
- Block
```
block_type{
    attribute1 = value1
    attribute2 = value2
}
```
```
resource "aws_instace" "example"{
    ami = ""
    instance_type = "t2.micro"
    count = 3
    enabled = true
}
```
eg: Provider, Resource, local, data, variable blocks etc.
- Attributes
    - Key value pair

- Datatypes
    - String
    - Boolean
    - number
    - list [item1, item2]
    - Maps
        ```
        variable "example"{
            type = map
            value = {key1="value1", key2="value2"}
        }
        ```
- Conditions
```
resource "aws_instace" "backend"{
    type = var.environment == "developement" ? "t2.micro" : "t2.small"
}
```
- Function
there are inbuilt functions in HCL (hasicop language) like join, upper etc.
```
local{
    name = "some name"
    fruits = ["mango", "banana"]
    message = "hello ${upper(local.name)}, I love to eat $(join(",", local.fruits))"
}
```
- ResourceDependency
    Two types of dependency
    - Implicit
    - Explicit 

- Variables
    - Input 
        - Declare through "variable" block and other ways as well
        ```
        variable{
            key = "value"
        }
        ```
    - Output
    - Local
        - Can oly be used inside the module only
        ```
        local{
            name = "value"
            ...
        }
        ```