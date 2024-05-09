create or replace view aggView8545909161158694431 as select id as v3 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin3710369349565695181 as select movie_id as v14 from movie_keyword as mk, aggView8545909161158694431 where mk.keyword_id=aggView8545909161158694431.v3;
create or replace view aggView3412489344112309895 as select v14, COUNT(*) as annot from aggJoin3710369349565695181 group by v14;
create or replace view aggJoin7720923909838813581 as select id as v14, production_year as v18, annot from title as t, aggView3412489344112309895 where t.id=aggView3412489344112309895.v14 and production_year>2010;
create or replace view aggView6660959843891059000 as select v14, SUM(annot) as annot from aggJoin7720923909838813581 group by v14;
create or replace view aggJoin6986769689803796696 as select info_type_id as v1, info as v9, annot from movie_info_idx as mi_idx, aggView6660959843891059000 where mi_idx.movie_id=aggView6660959843891059000.v14 and info>'9.0';
create or replace view aggView7219249542302113023 as select v1, SUM(annot) as annot from aggJoin6986769689803796696 group by v1;
create or replace view aggJoin7718241982414958113 as select info as v2, annot from info_type as it, aggView7219249542302113023 where it.id=aggView7219249542302113023.v1 and info= 'rating';
select SUM(annot) as v26 from aggJoin7718241982414958113;
