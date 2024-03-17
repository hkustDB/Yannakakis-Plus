create or replace view aggView7095867725768286779 as select id as v15, title as v28, production_year as v29 from title as t where production_year>2000;
create or replace view aggJoin4590594818394329457 as select movie_id as v15, company_type_id as v1, note as v9, v28, v29 from movie_companies as mc, aggView7095867725768286779 where mc.movie_id=aggView7095867725768286779.v15 and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%';
create or replace view aggView8319784715738385312 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin5337846612471513626 as select v15, v9, v28, v29 from aggJoin4590594818394329457 join aggView8319784715738385312 using(v1);
create or replace view aggView5030795200778022309 as select v15, MIN(v28) as v28, MIN(v29) as v29, MIN(v9) as v27 from aggJoin5337846612471513626 group by v15;
create or replace view aggJoin263229184671314247 as select info_type_id as v3, v28, v29, v27 from movie_info_idx as mi_idx, aggView5030795200778022309 where mi_idx.movie_id=aggView5030795200778022309.v15;
create or replace view aggView4618458460045992979 as select v3, MIN(v28) as v28, MIN(v29) as v29, MIN(v27) as v27 from aggJoin263229184671314247 group by v3;
create or replace view aggJoin2910771041647371440 as select info as v4, v28, v29, v27 from info_type as it, aggView4618458460045992979 where it.id=aggView4618458460045992979.v3 and info= 'bottom 10 rank';
select MIN(v27) as v27,MIN(v28) as v28,MIN(v29) as v29 from aggJoin2910771041647371440;
