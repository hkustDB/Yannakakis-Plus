create or replace view aggView3038799543388446118 as select id as v3 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin5652255732982999231 as select movie_id as v14 from movie_keyword as mk, aggView3038799543388446118 where mk.keyword_id=aggView3038799543388446118.v3;
create or replace view aggView5421547828048446194 as select v14, COUNT(*) as annot from aggJoin5652255732982999231 group by v14;
create or replace view aggJoin122626232054066921 as select id as v14, production_year as v18, annot from title as t, aggView5421547828048446194 where t.id=aggView5421547828048446194.v14 and production_year>2005;
create or replace view aggView7627430038454843997 as select v14, SUM(annot) as annot from aggJoin122626232054066921 group by v14;
create or replace view aggJoin3442511905754120123 as select info_type_id as v1, info as v9, annot from movie_info_idx as mi_idx, aggView7627430038454843997 where mi_idx.movie_id=aggView7627430038454843997.v14 and info>'5.0';
create or replace view aggView5103173282760283987 as select v1, SUM(annot) as annot from aggJoin3442511905754120123 group by v1;
create or replace view aggJoin4211404846413056999 as select info as v2, annot from info_type as it, aggView5103173282760283987 where it.id=aggView5103173282760283987.v1 and info= 'rating';
select SUM(annot) as v26 from aggJoin4211404846413056999;
