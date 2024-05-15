create or replace view aggView324311725117686420 as select id as v3 from info_type as it;
create or replace view aggJoin8869464450939662463 as select movie_id as v15, info as v13 from movie_info as mi, aggView324311725117686420 where mi.info_type_id=aggView324311725117686420.v3 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American');
create or replace view aggView960858551331327639 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin3722286528531514961 as select movie_id as v15, note as v9 from movie_companies as mc, aggView960858551331327639 where mc.company_type_id=aggView960858551331327639.v1 and note LIKE '%(USA)%' and note NOT LIKE '%(TV)%';
create or replace view aggView3798818785615350496 as select v15 from aggJoin8869464450939662463 group by v15;
create or replace view aggJoin6509054772762895353 as select v15, v9 from aggJoin3722286528531514961 join aggView3798818785615350496 using(v15);
create or replace view aggView5597501277362189667 as select v15 from aggJoin6509054772762895353 group by v15;
create or replace view aggJoin573521644822675315 as select title as v16 from title as t, aggView5597501277362189667 where t.id=aggView5597501277362189667.v15 and production_year>1990;
select MIN(v16) as v27 from aggJoin573521644822675315;
