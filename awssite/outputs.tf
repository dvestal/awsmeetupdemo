output "aws-machine" {
  value = "${aws_instance.web.public_ip}"
}
