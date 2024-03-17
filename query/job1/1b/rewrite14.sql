create or replace view aggView333417100505991915 as select id as v15, title as v28, production_year as v29 from title as t where production_year<=2010 and production_year>=2005;
create or replace view aggJoin7788752343750205512 as select movie_id as v15, company_type_id as v1, note as v9, v28, v29 from movie_companies as mc, aggView333417100505991915 where mc.movie_id=aggView333417100505991915.v15 and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%';
create or replace view aggView8974745264140174114 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin1878651754149220356 as select v15, v9, v28, v29 from aggJoin7788752343750205512 join aggView8974745264140174114 using(v1);
create or replace view aggView9144472848893217166 as select id as v3 from info_type as it where info= 'bottom 10 rank';
create or replace view aggJoin6322964379790091747 as select movie_id as v15 from movie_info_idx as mi_idx, aggView9144472848893217166 where mi_idx.info_type_id=aggView9144472848893217166.v3;
create or replace view aggView8669859678636216474 as select v15 from aggJoin6322964379790091747 group by v15;
create or replace view aggJoin4977725621127954758 as select v9, v28 as v28, v29 as v29 from aggJoin1878651754149220356 join aggView8669859678636216474 using(v15);
select MIN(v9) as v27,MIN(v28) as v28,MIN(v29) as v29 from aggJoin4977725621127954758;
