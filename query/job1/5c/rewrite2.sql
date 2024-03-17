create or replace view aggView9073902266002156868 as select id as v15, title as v27 from title as t where production_year>1990;
create or replace view aggJoin5352736454620270553 as select movie_id as v15, company_type_id as v1, note as v9, v27 from movie_companies as mc, aggView9073902266002156868 where mc.movie_id=aggView9073902266002156868.v15 and note LIKE '%(USA)%' and note NOT LIKE '%(TV)%';
create or replace view aggView8436634250117678887 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin6223330834643983042 as select v15, v9, v27 from aggJoin5352736454620270553 join aggView8436634250117678887 using(v1);
create or replace view aggView157082982390870520 as select v15, MIN(v27) as v27 from aggJoin6223330834643983042 group by v15;
create or replace view aggJoin4550097049932894640 as select info_type_id as v3, info as v13, v27 from movie_info as mi, aggView157082982390870520 where mi.movie_id=aggView157082982390870520.v15 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American');
create or replace view aggView7456678137354025756 as select id as v3 from info_type as it;
create or replace view aggJoin161395256036127240 as select v13, v27 from aggJoin4550097049932894640 join aggView7456678137354025756 using(v3);
select MIN(v27) as v27 from aggJoin161395256036127240;
