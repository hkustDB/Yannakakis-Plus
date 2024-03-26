create or replace view aggView5506817789609621359 as select id as v1 from info_type as it where info= 'rating';
create or replace view aggJoin3350975243205569741 as select movie_id as v14, info as v9 from movie_info_idx as mi_idx, aggView5506817789609621359 where mi_idx.info_type_id=aggView5506817789609621359.v1 and info>'5.0';
create or replace view aggView744950997128585044 as select v14, MIN(v9) as v26 from aggJoin3350975243205569741 group by v14;
create or replace view aggJoin8608134169837600725 as select id as v14, title as v15, v26 from title as t, aggView744950997128585044 where t.id=aggView744950997128585044.v14 and production_year>2005;
create or replace view aggView8017155597759684158 as select v14, MIN(v26) as v26, MIN(v15) as v27 from aggJoin8608134169837600725 group by v14;
create or replace view aggJoin8735686995194952450 as select keyword_id as v3, v26, v27 from movie_keyword as mk, aggView8017155597759684158 where mk.movie_id=aggView8017155597759684158.v14;
create or replace view aggView4300264307841379950 as select id as v3 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin1078689558757926187 as select v26, v27 from aggJoin8735686995194952450 join aggView4300264307841379950 using(v3);
select MIN(v26) as v26,MIN(v27) as v27 from aggJoin1078689558757926187;
