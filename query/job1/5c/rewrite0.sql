create or replace view aggView2560665191082605806 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin5788165684257321293 as select movie_id as v15, note as v9 from movie_companies as mc, aggView2560665191082605806 where mc.company_type_id=aggView2560665191082605806.v1 and note LIKE '%(USA)%' and note NOT LIKE '%(TV)%';
create or replace view aggView710873160958567233 as select v15 from aggJoin5788165684257321293 group by v15;
create or replace view aggJoin1158166715576697157 as select id as v15, title as v16 from title as t, aggView710873160958567233 where t.id=aggView710873160958567233.v15 and production_year>1990;
create or replace view aggView8433480337772757216 as select v15, MIN(v16) as v27 from aggJoin1158166715576697157 group by v15;
create or replace view aggJoin5838763747900633302 as select info_type_id as v3, v27 from movie_info as mi, aggView8433480337772757216 where mi.movie_id=aggView8433480337772757216.v15 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American');
create or replace view aggView4807243851818028905 as select v3, MIN(v27) as v27 from aggJoin5838763747900633302 group by v3;
create or replace view aggJoin2676961435924206302 as select v27 from info_type as it, aggView4807243851818028905 where it.id=aggView4807243851818028905.v3;
select MIN(v27) as v27 from aggJoin2676961435924206302;
