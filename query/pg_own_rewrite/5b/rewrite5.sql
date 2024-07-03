create or replace view aggView7447273495826558433 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin7681437250145379337 as select movie_id as v15, note as v9 from movie_companies as mc, aggView7447273495826558433 where mc.company_type_id=aggView7447273495826558433.v1 and note LIKE '%(USA)%' and note LIKE '%(VHS)%' and note LIKE '%(1994)%';
create or replace view aggView1910700455056715467 as select id as v3 from info_type as it;
create or replace view aggJoin6826110602650572621 as select movie_id as v15, info as v13 from movie_info as mi, aggView1910700455056715467 where mi.info_type_id=aggView1910700455056715467.v3 and info IN ('USA','America');
create or replace view aggView2668814427468817004 as select id as v15, title as v27 from title as t where production_year>2010;
create or replace view aggJoin7179227423050523738 as select v15, v13, v27 from aggJoin6826110602650572621 join aggView2668814427468817004 using(v15);
create or replace view aggView6779610291849341581 as select v15 from aggJoin7681437250145379337 group by v15;
create or replace view aggJoin5777036671832820903 as select v27 as v27 from aggJoin7179227423050523738 join aggView6779610291849341581 using(v15);
select MIN(v27) as v27 from aggJoin5777036671832820903;
