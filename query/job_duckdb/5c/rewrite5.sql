create or replace view aggView5960889644249905183 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin7508392118279300008 as select movie_id as v15, note as v9 from movie_companies as mc, aggView5960889644249905183 where mc.company_type_id=aggView5960889644249905183.v1 and note LIKE '%(USA)%' and note NOT LIKE '%(TV)%';
create or replace view aggView7157404474249699923 as select id as v3 from info_type as it;
create or replace view aggJoin3613586022696020306 as select movie_id as v15, info as v13 from movie_info as mi, aggView7157404474249699923 where mi.info_type_id=aggView7157404474249699923.v3 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American');
create or replace view aggView2545758187264738388 as select v15 from aggJoin7508392118279300008 group by v15;
create or replace view aggJoin4198293520493358638 as select v15, v13 from aggJoin3613586022696020306 join aggView2545758187264738388 using(v15);
create or replace view aggView5379377790129857415 as select v15 from aggJoin4198293520493358638 group by v15;
create or replace view aggJoin6369063318806688787 as select title as v16 from title as t, aggView5379377790129857415 where t.id=aggView5379377790129857415.v15 and production_year>1990;
select MIN(v16) as v27 from aggJoin6369063318806688787;
