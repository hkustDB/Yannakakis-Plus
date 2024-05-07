create or replace view aggView1827891937140904355 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin8416074171308750218 as select movie_id as v12 from movie_keyword as mk, aggView1827891937140904355 where mk.keyword_id=aggView1827891937140904355.v1;
create or replace view aggView1591049873822119817 as select v12 from aggJoin8416074171308750218 group by v12;
create or replace view aggJoin8816902067187126380 as select movie_id as v12, info as v7 from movie_info as mi, aggView1591049873822119817 where mi.movie_id=aggView1591049873822119817.v12 and info= 'Bulgaria';
create or replace view aggView9018792427318173467 as select v12 from aggJoin8816902067187126380 group by v12;
create or replace view aggJoin8013820551893571272 as select title as v13, production_year as v16 from title as t, aggView9018792427318173467 where t.id=aggView9018792427318173467.v12 and production_year>2010;
create or replace view aggView4113585807504700582 as select v13 from aggJoin8013820551893571272;
select MIN(v13) as v24 from aggView4113585807504700582;
