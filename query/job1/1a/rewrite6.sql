create or replace view aggView2614586689823252335 as select id as v3 from info_type as it where info= 'top 250 rank';
create or replace view aggJoin812082170128723734 as select movie_id as v15 from movie_info_idx as mi_idx, aggView2614586689823252335 where mi_idx.info_type_id=aggView2614586689823252335.v3;
create or replace view aggView2640654585112980750 as select v15 from aggJoin812082170128723734 group by v15;
create or replace view aggJoin5514582940243649172 as select id as v15, title as v16, production_year as v19 from title as t, aggView2640654585112980750 where t.id=aggView2640654585112980750.v15;
create or replace view aggView2987653183305220321 as select v15, MIN(v16) as v28, MIN(v19) as v29 from aggJoin5514582940243649172 group by v15;
create or replace view aggJoin2318359712380107836 as select company_type_id as v1, note as v9, v28, v29 from movie_companies as mc, aggView2987653183305220321 where mc.movie_id=aggView2987653183305220321.v15 and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%' and ((note LIKE '%(co-production)%') OR (note LIKE '%(presents)%'));
create or replace view aggView2811927109008045319 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin819327526258966325 as select v9, v28, v29 from aggJoin2318359712380107836 join aggView2811927109008045319 using(v1);
select MIN(v9) as v27,MIN(v28) as v28,MIN(v29) as v29 from aggJoin819327526258966325;
