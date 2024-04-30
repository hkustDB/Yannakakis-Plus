create or replace view aggView8337393401266295734 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin4651789874515702724 as select movie_id as v15, note as v9 from movie_companies as mc, aggView8337393401266295734 where mc.company_type_id=aggView8337393401266295734.v1 and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%';
create or replace view aggView8524720043399978095 as select v15, MIN(v9) as v27 from aggJoin4651789874515702724 group by v15;
create or replace view aggJoin8097449433183051320 as select id as v15, title as v16, production_year as v19, v27 from title as t, aggView8524720043399978095 where t.id=aggView8524720043399978095.v15 and production_year<=2010 and production_year>=2005;
create or replace view aggView8898948797987931086 as select v15, MIN(v27) as v27, MIN(v16) as v28, MIN(v19) as v29 from aggJoin8097449433183051320 group by v15;
create or replace view aggJoin8732487381265795306 as select info_type_id as v3, v27, v28, v29 from movie_info_idx as mi_idx, aggView8898948797987931086 where mi_idx.movie_id=aggView8898948797987931086.v15;
create or replace view aggView2175712412857030543 as select id as v3 from info_type as it where info= 'bottom 10 rank';
create or replace view aggJoin2877616579347696237 as select v27, v28, v29 from aggJoin8732487381265795306 join aggView2175712412857030543 using(v3);
select MIN(v27) as v27,MIN(v28) as v28,MIN(v29) as v29 from aggJoin2877616579347696237;
