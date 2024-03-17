create or replace view aggView7555215984532678075 as select id as v15, title as v27 from title as t where production_year>1990;
create or replace view aggJoin1781779113925683762 as select movie_id as v15, info_type_id as v3, info as v13, v27 from movie_info as mi, aggView7555215984532678075 where mi.movie_id=aggView7555215984532678075.v15 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American');
create or replace view aggView3368641889551325551 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin1630417151821715214 as select movie_id as v15, note as v9 from movie_companies as mc, aggView3368641889551325551 where mc.company_type_id=aggView3368641889551325551.v1 and note LIKE '%(USA)%' and note NOT LIKE '%(TV)%';
create or replace view aggView3873467967117309641 as select id as v3 from info_type as it;
create or replace view aggJoin8748756047132619789 as select v15, v13, v27 from aggJoin1781779113925683762 join aggView3873467967117309641 using(v3);
create or replace view aggView8474856959920223257 as select v15, MIN(v27) as v27 from aggJoin8748756047132619789 group by v15;
create or replace view aggJoin7635526838042590043 as select v9, v27 from aggJoin1630417151821715214 join aggView8474856959920223257 using(v15);
select MIN(v27) as v27 from aggJoin7635526838042590043;
