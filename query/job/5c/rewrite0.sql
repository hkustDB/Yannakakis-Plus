create or replace view aggView9179112625037145664 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin6522351537089338543 as select movie_id as v15, note as v9 from movie_companies as mc, aggView9179112625037145664 where mc.company_type_id=aggView9179112625037145664.v1 and note LIKE '%(USA)%' and note NOT LIKE '%(TV)%';
create or replace view aggView2962500244702952456 as select v15 from aggJoin6522351537089338543 group by v15;
create or replace view aggJoin1589057773696543724 as select id as v15, title as v16, production_year as v19 from title as t, aggView2962500244702952456 where t.id=aggView2962500244702952456.v15 and production_year>1990;
create or replace view aggView4857309827756938563 as select v15, MIN(v16) as v27 from aggJoin1589057773696543724 group by v15;
create or replace view aggJoin784609488310557657 as select info_type_id as v3, info as v13, v27 from movie_info as mi, aggView4857309827756938563 where mi.movie_id=aggView4857309827756938563.v15 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American');
create or replace view aggView8574515709516503220 as select id as v3 from info_type as it;
create or replace view aggJoin2181056193082457827 as select v13, v27 from aggJoin784609488310557657 join aggView8574515709516503220 using(v3);
select MIN(v27) as v27 from aggJoin2181056193082457827;
