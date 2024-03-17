create or replace view aggView7940403641848054504 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin3441778093846121313 as select movie_id as v15, note as v9 from movie_companies as mc, aggView7940403641848054504 where mc.company_type_id=aggView7940403641848054504.v1 and note LIKE '%(USA)%' and note NOT LIKE '%(TV)%';
create or replace view aggView2217300044980256577 as select v15 from aggJoin3441778093846121313 group by v15;
create or replace view aggJoin2929283238323447918 as select id as v15, title as v16 from title as t, aggView2217300044980256577 where t.id=aggView2217300044980256577.v15 and production_year>1990;
create or replace view aggView8396088719747890666 as select id as v3 from info_type as it;
create or replace view aggJoin2997226270065097675 as select movie_id as v15 from movie_info as mi, aggView8396088719747890666 where mi.info_type_id=aggView8396088719747890666.v3 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American');
create or replace view aggView2083198283095363091 as select v15 from aggJoin2997226270065097675 group by v15;
create or replace view aggJoin2428319342532773721 as select v16 from aggJoin2929283238323447918 join aggView2083198283095363091 using(v15);
select MIN(v16) as v27 from aggJoin2428319342532773721;
