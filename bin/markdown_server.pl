#!/usr/bin/perl

use strict;
use warnings;
use HTTP::Server::Simple::CGI;
use Text::Markdown 'markdown';

# Get the document root from command line arguments
my $port = 8080;  # Port number
my $doc_root = shift || die "Usage: $0 <document_root>\n";

# Create a subclass of HTTP::Server::Simple::CGI
package MyServer;
use base qw(HTTP::Server::Simple::CGI);

sub handle_request {
    my ($self, $cgi) = @_;
    my $path = $cgi->path_info || '/';
    my $file = $doc_root . $path;

    if (-f $file && $file =~ /\.md$/) {
        # Serve Markdown file as HTML
        open my $fh, '<', $file or die "Can't open $file: $!";
        my $markdown = do { local $/; <$fh> };
        close $fh;

        print $cgi->header('text/html');
        print markdown($markdown);
    } else {
        # Serve other files or return 404
        if (-f $file) {
            open my $fh, '<', $file or die "Can't open $file: $!";
            print $cgi->header('text/plain');
            print while <$fh>;
            close $fh;
        } else {
            print $cgi->header(-status => '404 Not Found');
            print "File not found";
        }
    }
}

# Start the server
my $server = MyServer->new(port => $port);
print "Starting server on port $port with document root $doc_root...\n";
$server->run();

