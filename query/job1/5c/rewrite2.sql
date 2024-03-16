create or replace view aggView8185821286173260004 as select id as v3 from info_type as it;
create or replace view aggJoin2493874001821760879 as select movie_id as v15, info as v13 from movie_info as mi, aggView8185821286173260004 where mi.info_type_id=aggView8185821286173260004.v3 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American');
create or replace view aggView811692422082610358 as select v15 from aggJoin2493874001821760879 group by v15;
create or replace view aggJoin7467259873888127208 as select id as v15, title as v16 from title as t, aggView811692422082610358 where t.id=aggView811692422082610358.v15 and production_year>1990;
create or replace view aggView2901831642074157719 as select v15, MIN(v16) as v27 from aggJoin7467259873888127208 group by v15;
create or replace view aggJoin8423512127928238453 as select company_type_id as v1, v27 from movie_companies as mc, aggView2901831642074157719 where mc.movie_id=aggView2901831642074157719.v15 and note LIKE '%(USA)%' and note NOT LIKE '%(TV)%';
create or replace view aggView4638399792092621490 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin4524812994425886524 as select v27 from aggJoin8423512127928238453 join aggView4638399792092621490 using(v1);
select MIN(v27) as v27 from aggJoin4524812994425886524;
