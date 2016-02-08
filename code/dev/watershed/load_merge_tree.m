function mt = load_merge_tree( fname )

    mt.vals  = double(load_dend_values([fname '.dend_values']));
    mt.pairs = uint32(load_dend_pairs([fname '.dend_pairs']));

end