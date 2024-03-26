create or replace view aggView1263119554712572932 as select id as v15, title as v27 from title as t where production_year>1990;
create or replace view aggJoin9099366592094836696 as select movie_id as v15, company_type_id as v1, note as v9, v27 from movie_companies as mc, aggView1263119554712572932 where mc.movie_id=aggView1263119554712572932.v15 and note LIKE '%(USA)%' and note NOT LIKE '%(TV)%';
create or replace view aggView23211920915139819 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin8686523815341938648 as select v15, v9, v27 from aggJoin9099366592094836696 join aggView23211920915139819 using(v1);
create or replace view aggView5336833015223509064 as select v15, MIN(v27) as v27 from aggJoin8686523815341938648 group by v15;
create or replace view aggJoin1582153761210137956 as select info_type_id as v3, info as v13, v27 from movie_info as mi, aggView5336833015223509064 where mi.movie_id=aggView5336833015223509064.v15 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American');
create or replace view aggView6563890373802956194 as select v3, MIN(v27) as v27 from aggJoin1582153761210137956 group by v3;
create or replace view aggJoin5124822940597112474 as select v27 from info_type as it, aggView6563890373802956194 where it.id=aggView6563890373802956194.v3;
select MIN(v27) as v27 from aggJoin5124822940597112474;
