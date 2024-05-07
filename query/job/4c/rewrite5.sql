create or replace view aggView5219402768623328176 as select id as v14, title as v27 from title as t where production_year>1990;
create or replace view aggJoin367910226366407613 as select movie_id as v14, info_type_id as v1, info as v9, v27 from movie_info_idx as mi_idx, aggView5219402768623328176 where mi_idx.movie_id=aggView5219402768623328176.v14 and info>'2.0';
create or replace view aggView3192187315817342594 as select id as v1 from info_type as it where info= 'rating';
create or replace view aggJoin6392035324171139200 as select v14, v9, v27 from aggJoin367910226366407613 join aggView3192187315817342594 using(v1);
create or replace view aggView2569481358538791686 as select v14, MIN(v27) as v27, MIN(v9) as v26 from aggJoin6392035324171139200 group by v14;
create or replace view aggJoin1062007492757694729 as select keyword_id as v3, v27, v26 from movie_keyword as mk, aggView2569481358538791686 where mk.movie_id=aggView2569481358538791686.v14;
create or replace view aggView3770128616918019395 as select id as v3 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin1411107465029063902 as select v27, v26 from aggJoin1062007492757694729 join aggView3770128616918019395 using(v3);
select MIN(v26) as v26,MIN(v27) as v27 from aggJoin1411107465029063902;
