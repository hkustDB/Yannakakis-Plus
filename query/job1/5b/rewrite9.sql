create or replace view aggView5863994935238109960 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin242778896328655896 as select movie_id as v15, note as v9 from movie_companies as mc, aggView5863994935238109960 where mc.company_type_id=aggView5863994935238109960.v1 and note LIKE '%(USA)%' and note LIKE '%(VHS)%' and note LIKE '%(1994)%';
create or replace view aggView3256037285820442601 as select v15 from aggJoin242778896328655896 group by v15;
create or replace view aggJoin3153169359533557614 as select id as v15, title as v16 from title as t, aggView3256037285820442601 where t.id=aggView3256037285820442601.v15 and production_year>2010;
create or replace view aggView3784877441133000319 as select id as v3 from info_type as it;
create or replace view aggJoin1806709940519759854 as select movie_id as v15 from movie_info as mi, aggView3784877441133000319 where mi.info_type_id=aggView3784877441133000319.v3 and info IN ('USA','America');
create or replace view aggView460482436502848377 as select v15 from aggJoin1806709940519759854 group by v15;
create or replace view aggJoin6777631003923994854 as select v16 from aggJoin3153169359533557614 join aggView460482436502848377 using(v15);
select MIN(v16) as v27 from aggJoin6777631003923994854;
