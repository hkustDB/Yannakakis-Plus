create or replace view aggView1773588646085758310 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin6820916696857444838 as select movie_id as v12 from movie_keyword as mk, aggView1773588646085758310 where mk.keyword_id=aggView1773588646085758310.v1;
create or replace view aggView802605871175107491 as select movie_id as v12 from movie_info as mi where info= 'Bulgaria' group by movie_id;
create or replace view aggJoin6077326590571135176 as select id as v12, title as v13, production_year as v16 from title as t, aggView802605871175107491 where t.id=aggView802605871175107491.v12 and production_year>2010;
create or replace view aggView9136361916294934699 as select v12 from aggJoin6820916696857444838 group by v12;
create or replace view aggJoin3206785020945150731 as select v13, v16 from aggJoin6077326590571135176 join aggView9136361916294934699 using(v12);
create or replace view aggView3782908382613674424 as select v13 from aggJoin3206785020945150731;
select MIN(v13) as v24 from aggView3782908382613674424;
