create or replace view aggView8031865081031402548 as select id as v3 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin3775191425233559446 as select movie_id as v14 from movie_keyword as mk, aggView8031865081031402548 where mk.keyword_id=aggView8031865081031402548.v3;
create or replace view aggView3423376802555635640 as select v14, COUNT(*) as annot from aggJoin3775191425233559446 group by v14;
create or replace view aggJoin2329685600170721321 as select id as v14, production_year as v18, annot from title as t, aggView3423376802555635640 where t.id=aggView3423376802555635640.v14 and production_year>1990;
create or replace view aggView1835275870617454961 as select v14, SUM(annot) as annot from aggJoin2329685600170721321 group by v14;
create or replace view aggJoin6952977022878582128 as select info_type_id as v1, info as v9, annot from movie_info_idx as mi_idx, aggView1835275870617454961 where mi_idx.movie_id=aggView1835275870617454961.v14 and info>'2.0';
create or replace view aggView2163039655648795033 as select v1, SUM(annot) as annot from aggJoin6952977022878582128 group by v1;
create or replace view aggJoin7074452195636413240 as select info as v2, annot from info_type as it, aggView2163039655648795033 where it.id=aggView2163039655648795033.v1 and info= 'rating';
select SUM(annot) as v26 from aggJoin7074452195636413240;
