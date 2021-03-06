%%
%% PDF Type Definitions
%%

-type pdf_server_pid() :: pid().

%% X, Y, Width, Height
-type xywh() :: {integer(), integer(), integer(), integer()}.

-type rgb_color() :: {byte(), byte(), byte()}.
-type color() :: atom() | rgb_color().

-type img_size_t() :: {max, undefined | number(), undefined | number()}
    | {width | height, number()} | {size, tuple()}
    | {integer(), integer()}.

-type val_t() :: {name | string, string()} | dict_val_t() | ptr_val_t().
-type ptr_val_t() :: {ptr, number(), number()}.
-type dict_val_t() :: {dict, list({string(), val_t()})}.

%%
%% Rich Text Type Definitions
%%

-ifdef(FACE_RECORD_DEFINED).
    -type face() :: #face{}.
-else.
    -type face() :: tuple().
-endif.

-type ep_rich_text() :: {richText, [any_inline()]}.
-type any_inline() :: word() | opaque() | space() | nl() | fixed_str().
-type word() :: {word, Width :: milli_points(), Face :: face(), string()}.
-type space() :: {space, Width :: milli_points(), Face :: face()}.
-type nl() :: {nl, Face :: face()}.
-type fixed_str() :: {fixedStr, Width :: milli_points(), _, _}.
-type opaque() :: {opaque, Width :: milli_points(), _}.
-type milli_points() :: integer().
-type points() :: integer().

%%
%% Text and Paragraph Layout Type Definitions
%%

-type line_split_t() :: justified | spill | left_justified | ragged
    | right_justified | ragged_left | ragged_force_split | simple_hyphenate
    | preformatted | centered.

-type paper_stock() :: a0 | a1 | a2 | a3 | a4 | a5 | a6 | a7 | a8 | a9 | a10
    | avery_labels | avery_labels_5164 | avery_labels_8168
    | envelope_no10 | legal | letter | tabloid.

-type page_format() :: a0 | a1 | a2 | a3 | a4 | a5 | a6 | a7 | a8 | a9 | b0 |
    b1 | b2 | b3 | b4 | b5 | b6 | b7 | b8 | b9 | b10 | avery_5164 |
    avery_8168 | book1 | book4 | book3 | book4 | book5 | book6 | book7 |
    bookmark | business_card | envelope_no10 | invoice | ledger | legal |
    letter | postcard1 | postcard2 | postcard3 | report | tabloid.

-type leading() :: number().
-type direction() :: up | down | left | right.
-type edge() :: top | right | bottom | left.

%%
%% Path Drawing and Filling Types
%%

-type line_cap_t() :: flat_cap | round_cap | square_cap | integer().
-type line_join_t() :: miter_join | round_join | bevel_join | integer().
-type line_style() :: solid | dash | dot | dashdot | string().

-type path_t() :: close | close_strike | fill | fill_even_odd
    | fill_stroke | fill_then_stroke | fill_stroke_even_odd | close_fill_stroke
    | close_fill_stroke_even_odd | endpath | stroke().

-type stroke() :: stroke.

%% A pair of integers or floats which defines a point or size.
-type xy() :: {number(), number()}.

%% A pair of integers which defines a point or size.
-type integer_xy() :: {integer(), integer()}.

%% same as integer_xy() just for clarity
-type points_xy() :: {points(), points()}.

%% A pair of points which defines a box or a line.
-type xy1_xy2() :: {xy(), xy()}.

%%
%%----------------------
%%

-type ep_job() :: #{
    title => iolist() | undefined,
    published => iolist() | undefined,
    path => file:filename(),
    directory => file:filename(),
    author => string() | undefined,
    subject => string() | undefined,
    description => string() | undefined,
    keywords => any(),
    start_date => any(),
    deadline => any(),
    paper_stock => paper_stock(),
    page_format => page_format()
}.

-type ep_panel_id() :: {PageNumber :: integer(),
                        PanelIndex :: integer(),
                        PanelName :: string() | atom()}.
-type ep_panel() :: #{
    id                => ep_panel_id(),
    position          => xy(),
    size              => xy(),
    radius            => number(),
    content_cursor    => number(),
    border            => number(),
    border_style      => atom(),
    border_color      => color(),
    background_color  => color(),
    margin            => points(),
    typestyle         => atom(),
    li_fill           => color(),
    indent            => points(),
    rot               => number(),
    jump_prompt       => string()
}.

%%
%% Custom XML Parser
%% TODO: Replace with a default or open-source parser
%%
-type eg_xmlform() :: {atom(), Attrs :: proplists:proplist(),
                       Nested :: list(eg_xmlform())}.
-type eg_xml() :: list(eg_xmlform()).

-type ep_bezier() :: #{
    from => xy(),
    to => xy(),
    pt2 => xy(),
    pt3 => xy(),
    width => points(),
    color => color()
}.

-type ep_line() :: #{
    from => xy(),
    to => xy(),
    color => color(),
    width => points(),
    dash => atom()
}.

-type ep_line_list() :: #{ lines => list(ep_line())}.

-type ep_page_number() :: #{
    from => tuple(),
    text => string(),
    font => string(),
    font_size => points()
}.

-type ep_checkbox() :: #{
    box_position  => xy(),
    width         => points(),
    height        => points(),
    outline       => points(),
    outline_type  => atom(),
    outline_color => color(),
    fill_color    => color()
}.

-type ep_circle() :: #{
    center        => xy(),
    radius        => points(),
    border        => points(),
    border_style  => line_style(),
    border_color  => color(),
    fill_color    => color()
}.

-type ep_ellipse() :: #{
    center         => xy(),
    axes           => xy1_xy2(),
    border         => points(),
    border_style   => line_style(),
    border_color   => color(),
    fill_color     => color(),
    format         => page_format()
}.

-type ep_poly() :: #{
    vertices      => list(xy()),
    outline       => points(),
    dash          => line_style(),
    outline_color => color(),
    fill_color    => color()
}.

-type ep_rectangle() :: #{
    position       => xy(),
    size           => xy(),
    outline        => points(),
    outline_style  => line_style(),
    outline_color  => color(),
    fill_color     => color()
}.

-type ep_round_rect() :: #{
    position          => xy(),
    size              => xy(),
    radius            => points(),
    border            => points(),
    border_style      => line_style(),
    border_color      => color(),
    background_color  => color()
}.

-type ep_text() ::    #{
    font          => string(),
    position      => xy(),
    size          => points(),
    text_color    => color(),
    justification => atom(),
    rot           => number(),
    leading       => points()
}.

-type ep_font_face() :: #{
    font        => string(),
    size        => points(),
    breakable   => boolean(),
    color       => color(),
    voffset     => points()
}.
