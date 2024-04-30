create or replace view aggView5460910041862254923 as select id as v3 from info_type as it;
create or replace view aggJoin4616094737024779520 as select movie_id as v15, info as v13 from movie_info as mi, aggView5460910041862254923 where mi.info_type_id=aggView5460910041862254923.v3 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German');
create or replace view aggView2896778726749145970 as select v15 from aggJoin4616094737024779520 group by v15;
create or replace view aggJoin1508623742078960374 as select movie_id as v15, company_type_id as v1, note as v9 from movie_companies as mc, aggView2896778726749145970 where mc.movie_id=aggView2896778726749145970.v15 and note LIKE '%(theatrical)%' and note LIKE '%(France)%';
create or replace view aggView1197395535224939821 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin2295946404501354462 as select v15, v9 from aggJoin1508623742078960374 join aggView1197395535224939821 using(v1);
create or replace view aggView1888777793356564587 as select v15 from aggJoin2295946404501354462 group by v15;
create or replace view aggJoin1459655000308046354 as select title as v16 from title as t, aggView1888777793356564587 where t.id=aggView1888777793356564587.v15 and production_year>2005;
select MIN(v16) as v27 from aggJoin1459655000308046354;
