create or replace view aggView834039950716563445 as select id as v12, title as v24 from title as t where production_year>2010;
create or replace view aggJoin894514466019596501 as select movie_id as v12, info as v7, v24 from movie_info as mi, aggView834039950716563445 where mi.movie_id=aggView834039950716563445.v12 and info= 'Bulgaria';
create or replace view aggView3733222648047904657 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin2083045118055368210 as select movie_id as v12 from movie_keyword as mk, aggView3733222648047904657 where mk.keyword_id=aggView3733222648047904657.v1;
create or replace view aggView2198850543212728164 as select v12, MIN(v24) as v24 from aggJoin894514466019596501 group by v12,v24;
create or replace view aggJoin2193254804885319515 as select v24 from aggJoin2083045118055368210 join aggView2198850543212728164 using(v12);
select MIN(v24) as v24 from aggJoin2193254804885319515;
