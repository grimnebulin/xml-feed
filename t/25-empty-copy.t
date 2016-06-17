use strict;
use Test::More;
use XML::Feed;

my @FIELDS = qw(
    title base link description author language copyright modified
    generator self_link first_link last_link next_link previous_link
    current_link next_archive_link prev_archive_link
);

my $atom  = XML::Feed->parse('t/samples/atom.xml');
my $rss10 = XML::Feed->parse('t/samples/rss10.xml');
my $rss20 = XML::Feed->parse('t/samples/rss10.xml');

is_empty_copy_of($atom->empty_copy, $atom);
is_empty_copy_of($rss10->empty_copy, $rss10);
is_empty_copy_of($rss20->empty_copy, $rss20);
is_empty_copy_of($atom->empty_copy('RSS'), $atom, qr/^RSS\b/);
is_empty_copy_of($rss20->empty_copy('Atom'), $rss20, qr/^Atom\z/);

done_testing();

sub is_empty_copy_of {
    my ($copy, $source, $format) = @_;
    for my $field (@FIELDS) {
        is($copy->$field(), $source->$field());
    }
    if (defined $format) {
        like($copy->format, $format);
    } else {
        is($copy->format, $source->format);
    }
    is(0, () = $copy->entries);
}
