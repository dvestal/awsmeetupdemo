output "aws-machine" {
  value = "${aws_eip.webip.public_ip}"
}
