create or replace view aggView8137818390509077730 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin1941383478395780025 as select movie_id as v15, note as v9 from movie_companies as mc, aggView8137818390509077730 where mc.company_type_id=aggView8137818390509077730.v1 and note LIKE '%(theatrical)%' and note LIKE '%(France)%';
create or replace view aggView7869559877421413501 as select id as v3 from info_type as it;
create or replace view aggJoin8636611635641334308 as select movie_id as v15, info as v13 from movie_info as mi, aggView7869559877421413501 where mi.info_type_id=aggView7869559877421413501.v3 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German');
create or replace view aggView4781477641450427503 as select v15 from aggJoin1941383478395780025 group by v15;
create or replace view aggJoin8731311826454994909 as select v15, v13 from aggJoin8636611635641334308 join aggView4781477641450427503 using(v15);
create or replace view aggView2189226821981867042 as select v15 from aggJoin8731311826454994909 group by v15;
create or replace view aggJoin4928897692156711779 as select title as v16 from title as t, aggView2189226821981867042 where t.id=aggView2189226821981867042.v15 and production_year>2005;
select MIN(v16) as v27 from aggJoin4928897692156711779;
