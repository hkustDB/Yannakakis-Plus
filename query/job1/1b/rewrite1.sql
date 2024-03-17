create or replace view aggView2992797874334768877 as select id as v3 from info_type as it where info= 'bottom 10 rank';
create or replace view aggJoin2949491519305159921 as select movie_id as v15 from movie_info_idx as mi_idx, aggView2992797874334768877 where mi_idx.info_type_id=aggView2992797874334768877.v3;
create or replace view aggView5967792375284289231 as select v15 from aggJoin2949491519305159921 group by v15;
create or replace view aggJoin8210422108947365781 as select id as v15, title as v16, production_year as v19 from title as t, aggView5967792375284289231 where t.id=aggView5967792375284289231.v15 and production_year<=2010 and production_year>=2005;
create or replace view aggView6785087068418940885 as select v15, MIN(v16) as v28, MIN(v19) as v29 from aggJoin8210422108947365781 group by v15;
create or replace view aggJoin3504121009041192985 as select company_type_id as v1, note as v9, v28, v29 from movie_companies as mc, aggView6785087068418940885 where mc.movie_id=aggView6785087068418940885.v15 and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%';
create or replace view aggView166567030346029419 as select v1, MIN(v28) as v28, MIN(v29) as v29, MIN(v9) as v27 from aggJoin3504121009041192985 group by v1;
create or replace view aggJoin3527744643320591380 as select v28, v29, v27 from company_type as ct, aggView166567030346029419 where ct.id=aggView166567030346029419.v1 and kind= 'production companies';
select MIN(v27) as v27,MIN(v28) as v28,MIN(v29) as v29 from aggJoin3527744643320591380;
