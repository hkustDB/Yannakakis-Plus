create or replace view aggView1136626113346351877 as select id as v15, title as v28, production_year as v29 from title as t where production_year<=2010 and production_year>=2005;
create or replace view aggJoin7752876546372516157 as select movie_id as v15, company_type_id as v1, note as v9, v28, v29 from movie_companies as mc, aggView1136626113346351877 where mc.movie_id=aggView1136626113346351877.v15 and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%';
create or replace view aggView6531382055046867063 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin1099975090469776213 as select v15, v9, v28, v29 from aggJoin7752876546372516157 join aggView6531382055046867063 using(v1);
create or replace view aggView6937698033121292919 as select id as v3 from info_type as it where info= 'bottom 10 rank';
create or replace view aggJoin7154115002034180632 as select movie_id as v15 from movie_info_idx as mi_idx, aggView6937698033121292919 where mi_idx.info_type_id=aggView6937698033121292919.v3;
create or replace view aggView4311877859198062413 as select v15 from aggJoin7154115002034180632 group by v15;
create or replace view aggJoin5948662860344855993 as select v9, v28 as v28, v29 as v29 from aggJoin1099975090469776213 join aggView4311877859198062413 using(v15);
select MIN(v9) as v27,MIN(v28) as v28,MIN(v29) as v29 from aggJoin5948662860344855993;
