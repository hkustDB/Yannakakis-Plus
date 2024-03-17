create or replace view aggView5513270722508620185 as select id as v15, title as v27 from title as t where production_year>1990;
create or replace view aggJoin4650410154796436772 as select movie_id as v15, info_type_id as v3, info as v13, v27 from movie_info as mi, aggView5513270722508620185 where mi.movie_id=aggView5513270722508620185.v15 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American');
create or replace view aggView3994296426950173919 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin1819992559536400478 as select movie_id as v15, note as v9 from movie_companies as mc, aggView3994296426950173919 where mc.company_type_id=aggView3994296426950173919.v1 and note LIKE '%(USA)%' and note NOT LIKE '%(TV)%';
create or replace view aggView5570257852548544920 as select v15 from aggJoin1819992559536400478 group by v15;
create or replace view aggJoin5690701840416493817 as select v3, v13, v27 as v27 from aggJoin4650410154796436772 join aggView5570257852548544920 using(v15);
create or replace view aggView3726569086952436007 as select v3, MIN(v27) as v27 from aggJoin5690701840416493817 group by v3;
create or replace view aggJoin6251380580269385873 as select v27 from info_type as it, aggView3726569086952436007 where it.id=aggView3726569086952436007.v3;
select MIN(v27) as v27 from aggJoin6251380580269385873;
