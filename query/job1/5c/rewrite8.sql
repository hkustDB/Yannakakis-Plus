create or replace view aggView2983649141987849323 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin2502855736611422290 as select movie_id as v15, note as v9 from movie_companies as mc, aggView2983649141987849323 where mc.company_type_id=aggView2983649141987849323.v1 and note LIKE '%(USA)%' and note NOT LIKE '%(TV)%';
create or replace view aggView4299020403628083343 as select v15 from aggJoin2502855736611422290 group by v15;
create or replace view aggJoin6303292634718344455 as select id as v15, title as v16 from title as t, aggView4299020403628083343 where t.id=aggView4299020403628083343.v15 and production_year>1990;
create or replace view aggView7930781532214125996 as select v15, MIN(v16) as v27 from aggJoin6303292634718344455 group by v15;
create or replace view aggJoin4737386354685388762 as select info_type_id as v3, v27 from movie_info as mi, aggView7930781532214125996 where mi.movie_id=aggView7930781532214125996.v15 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American');
create or replace view aggView7916287430962345013 as select id as v3 from info_type as it;
create or replace view aggJoin3981819436363954451 as select v27 from aggJoin4737386354685388762 join aggView7916287430962345013 using(v3);
select MIN(v27) as v27 from aggJoin3981819436363954451;
