create or replace view aggView7098291149710388440 as select id as v3 from info_type as it;
create or replace view aggJoin3953152212876491696 as select movie_id as v15, info as v13 from movie_info as mi, aggView7098291149710388440 where mi.info_type_id=aggView7098291149710388440.v3 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German');
create or replace view aggView5366975813351695200 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin4385464422101421947 as select movie_id as v15, note as v9 from movie_companies as mc, aggView5366975813351695200 where mc.company_type_id=aggView5366975813351695200.v1 and note LIKE '%(theatrical)%' and note LIKE '%(France)%';
create or replace view aggView8312900648409674595 as select v15 from aggJoin3953152212876491696 group by v15;
create or replace view aggJoin4580298781461709235 as select v15, v9 from aggJoin4385464422101421947 join aggView8312900648409674595 using(v15);
create or replace view aggView4189671966054262354 as select v15 from aggJoin4580298781461709235 group by v15;
create or replace view aggJoin3068974046094709234 as select title as v16 from title as t, aggView4189671966054262354 where t.id=aggView4189671966054262354.v15 and production_year>2005;
select MIN(v16) as v27 from aggJoin3068974046094709234;
