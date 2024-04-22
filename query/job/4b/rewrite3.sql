create or replace view aggJoin4963202900453014705 as (
with aggView9010153747964534181 as (select id as v3 from keyword as k where keyword LIKE '%sequel%')
select movie_id as v14 from movie_keyword as mk, aggView9010153747964534181 where mk.keyword_id=aggView9010153747964534181.v3);
create or replace view aggJoin7917192540521441076 as (
with aggView1266597670397643338 as (select v14 from aggJoin4963202900453014705 group by v14)
select id as v14, title as v15, production_year as v18 from title as t, aggView1266597670397643338 where t.id=aggView1266597670397643338.v14 and production_year>2010);
create or replace view aggView3459679107611559137 as select v15, v14 from aggJoin7917192540521441076 group by v15,v14;
create or replace view aggJoin3009543895652241406 as (
with aggView8960703771720497453 as (select id as v1 from info_type as it where info= 'rating')
select movie_id as v14, info as v9 from movie_info_idx as mi_idx, aggView8960703771720497453 where mi_idx.info_type_id=aggView8960703771720497453.v1 and info>'9.0');
create or replace view aggView1856712528060704607 as select v9, v14 from aggJoin3009543895652241406 group by v9,v14;
create or replace view aggJoin849577440221319130 as (
with aggView8750182957035171069 as (select v14, MIN(v15) as v27 from aggView3459679107611559137 group by v14)
select v9, v27 from aggView1856712528060704607 join aggView8750182957035171069 using(v14));
select MIN(v9) as v26,MIN(v27) as v27 from aggJoin849577440221319130;
