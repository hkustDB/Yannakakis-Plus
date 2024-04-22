create or replace view aggJoin2988041297567126984 as (
with aggView3285786219480938258 as (select id as v14, title as v27 from title as t where production_year>1990)
select movie_id as v14, keyword_id as v3, v27 from movie_keyword as mk, aggView3285786219480938258 where mk.movie_id=aggView3285786219480938258.v14);
create or replace view aggJoin4915937680478021852 as (
with aggView8759525347093672160 as (select id as v1 from info_type as it where info= 'rating')
select movie_id as v14, info as v9 from movie_info_idx as mi_idx, aggView8759525347093672160 where mi_idx.info_type_id=aggView8759525347093672160.v1 and info>'2.0');
create or replace view aggJoin9047622519067692197 as (
with aggView227440217504282004 as (select v14, MIN(v9) as v26 from aggJoin4915937680478021852 group by v14)
select v3, v27 as v27, v26 from aggJoin2988041297567126984 join aggView227440217504282004 using(v14));
create or replace view aggJoin6215362191954621735 as (
with aggView6177262171443852229 as (select id as v3 from keyword as k where keyword LIKE '%sequel%')
select v27, v26 from aggJoin9047622519067692197 join aggView6177262171443852229 using(v3));
select MIN(v26) as v26,MIN(v27) as v27 from aggJoin6215362191954621735;
