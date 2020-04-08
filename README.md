# SBCL - Basic Client Server Example (Common Lisp)

## What

This is a basic client server example for Common Lisp. A basic example for using sockets. It's specifically for SBCL and uses usocket.

This is not meant to be a full practical example but only a basic example of how you get the communication going. Handling data, like for example storing it into an array, is a story for another day.

## Requirements

The scripts of course need SBCL (Steel Bank Common Lisp interpreter) and usocket. Regarding SBCL use the install manual for your operating system. You can use the scripts on Windows, on Linux, on Raspberries... In case you need to install usocket, QuickLisp is probably the best and easiest way to do it. The manual is in the attached file.

## Usage

Basically you just open two terminal windows (or tabs) and start the server first, then the client second.

On Linux you can just give it execution permission:

- chmod +x server.cl

- chmod +x client.cl

And run the scripts directly:

- ./server.cl

- ./client.cl

They communicate, the server prints the data the client sends and the client prints the message the server sends, then both terminate. To keep the connection open, you just skip closing the sockets. You could run both in the SBCL interpreter and keep sending messages back and forth.

### Notes

I did try the scripts between my notebook and a Raspberry Pi and it did work. However, know that you have to use the actual network address for the socket. Binding the socket for localhost doesn't seem to work for connections from the network. Also, I didn't always get the connection right away and the client has thrown a connection refused error a few times until it finally got through. It seems, the Raspberry processes this quite slowly. So, in production you might want to counter for that with proper error-handling, acknowledgement, retries...

## Explanation

If you have the basics down, given the files include comments, this should be fairly easy to understand. Both bind to the socket address (consists of IP address for localhost and port number, in this case 4123). The server starts listening (socket-accept) for incoming requests, both open a stream for communication (socket-stream), then the clients sends the request, they exchange the data and then close the connection (socket-close). Unwind-protect makes sure the socket gets closed in case, no matter what (meaning even in case an error occurs).

## Why?

Because it's sad how poor the information out there is. Despite books and the Internet and people who seem to have been using this stuff for years, it took me HOURS to figure out how it works. BASIC STUFF! It's sad how much time we waste for nothing, due to all the poor information and documentation out there.

The best thing I had, was a CLISP example. That's nice and simple and it actually works. The problem is, that the performance of CLISP is horrible compared to SBCL. So, CLISP might be nice for learning, but in actual practical use, not so much. Some examples I ran, were at least 8-9 times slower with CLISP than SBCL and up to like 20 times slower! And that's important for my purpose. But worse is, that the CLISP example doesn't work with SBCL.

Some additional problems I ran into were: 

- no useful info on library setup and use

- SBCL not loading .sbclrc out of the box. Which is why it's in the files. Which likely only works on Linux btw because of the path. You might want to modify that.

- barely any examples or simple explanation out there

- the few out there are either useless or don't work (properly), yet get copied and pasted on multiple pages and sites. I ran into TWO examples. One of which only downloaded a website and even that with an error. The second was poorly written, had no error handling AND has sent only PART of the data in ONE direction.

So, I hope you appreciate the effort and it's going to be helpful for you. This one is not a copy and paste but has actually been written by myself and tested and it works.