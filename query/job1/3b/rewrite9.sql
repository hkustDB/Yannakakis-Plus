create or replace view aggView8915259770094394076 as select movie_id as v12 from movie_info as mi where info= 'Bulgaria' group by movie_id;
create or replace view aggJoin4956602687005168445 as select id as v12, title as v13 from title as t, aggView8915259770094394076 where t.id=aggView8915259770094394076.v12 and production_year>2010;
create or replace view aggView752581510809080711 as select v12, MIN(v13) as v24 from aggJoin4956602687005168445 group by v12;
create or replace view aggJoin4862346380137833974 as select keyword_id as v1, v24 from movie_keyword as mk, aggView752581510809080711 where mk.movie_id=aggView752581510809080711.v12;
create or replace view aggView7043650739036020079 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin7051580891025270949 as select v24 from aggJoin4862346380137833974 join aggView7043650739036020079 using(v1);
select MIN(v24) as v24 from aggJoin7051580891025270949;
