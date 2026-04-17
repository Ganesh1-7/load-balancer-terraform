resource "aws_key_pair" "web-key" {
    public_key = file("web-key.pub")
}