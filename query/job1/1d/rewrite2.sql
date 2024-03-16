create or replace view aggView4398468743701767930 as select id as v3 from info_type as it where info= 'bottom 10 rank';
create or replace view aggJoin8183657359582107226 as select movie_id as v15 from movie_info_idx as mi_idx, aggView4398468743701767930 where mi_idx.info_type_id=aggView4398468743701767930.v3;
create or replace view aggView4991906890601063711 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin6859274537255183115 as select movie_id as v15, note as v9 from movie_companies as mc, aggView4991906890601063711 where mc.company_type_id=aggView4991906890601063711.v1 and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%';
create or replace view aggView4303429445750261180 as select v15, MIN(v9) as v27 from aggJoin6859274537255183115 group by v15;
create or replace view aggJoin6471286571674654670 as select id as v15, title as v16, production_year as v19, v27 from title as t, aggView4303429445750261180 where t.id=aggView4303429445750261180.v15 and production_year>2000;
create or replace view aggView3208166707268419711 as select v15, MIN(v27) as v27, MIN(v16) as v28, MIN(v19) as v29 from aggJoin6471286571674654670 group by v15;
create or replace view aggJoin5145932203129025599 as select v27, v28, v29 from aggJoin8183657359582107226 join aggView3208166707268419711 using(v15);
select MIN(v27) as v27,MIN(v28) as v28,MIN(v29) as v29 from aggJoin5145932203129025599;
