create or replace view aggView6216688649110817964 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin766217858201936860 as select movie_id as v12 from movie_keyword as mk, aggView6216688649110817964 where mk.keyword_id=aggView6216688649110817964.v1;
create or replace view aggView2662303445050675909 as select v12 from aggJoin766217858201936860 group by v12;
create or replace view aggJoin7080139286721822103 as select movie_id as v12, info as v7 from movie_info as mi, aggView2662303445050675909 where mi.movie_id=aggView2662303445050675909.v12 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German');
create or replace view aggView2267154885596410244 as select v12 from aggJoin7080139286721822103 group by v12;
create or replace view aggJoin1569588864150553682 as select title as v13, production_year as v16 from title as t, aggView2267154885596410244 where t.id=aggView2267154885596410244.v12 and production_year>2005;
create or replace view aggView2688916477811065431 as select v13 from aggJoin1569588864150553682;
select MIN(v13) as v24 from aggView2688916477811065431;
