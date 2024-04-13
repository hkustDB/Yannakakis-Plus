create or replace view aggView649555914478543537 as select id as v15, title as v28, production_year as v29 from title as t where production_year<=2010 and production_year>=2005;
create or replace view aggJoin1081548561273407125 as select movie_id as v15, info_type_id as v3, v28, v29 from movie_info_idx as mi_idx, aggView649555914478543537 where mi_idx.movie_id=aggView649555914478543537.v15;
create or replace view aggView4732173249312242140 as select id as v3 from info_type as it where info= 'bottom 10 rank';
create or replace view aggJoin2133508491492296782 as select v15, v28, v29 from aggJoin1081548561273407125 join aggView4732173249312242140 using(v3);
create or replace view aggView1044185938139887546 as select v15, MIN(v28) as v28, MIN(v29) as v29 from aggJoin2133508491492296782 group by v15,v28,v29;
create or replace view aggJoin4192895782809272319 as select company_type_id as v1, note as v9, v28, v29 from movie_companies as mc, aggView1044185938139887546 where mc.movie_id=aggView1044185938139887546.v15 and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%';
create or replace view aggView5066921064359761441 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin4424614060691470859 as select v9, v28, v29 from aggJoin4192895782809272319 join aggView5066921064359761441 using(v1);
select MIN(v9) as v27,MIN(v28) as v28,MIN(v29) as v29 from aggJoin4424614060691470859;
