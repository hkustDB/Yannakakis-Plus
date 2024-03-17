create or replace view aggView6061526782599041611 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin410093586134891797 as select movie_id as v15, note as v9 from movie_companies as mc, aggView6061526782599041611 where mc.company_type_id=aggView6061526782599041611.v1 and note LIKE '%(theatrical)%' and note LIKE '%(France)%';
create or replace view aggView9095616317594408056 as select v15 from aggJoin410093586134891797 group by v15;
create or replace view aggJoin119854284420516583 as select movie_id as v15, info_type_id as v3, info as v13 from movie_info as mi, aggView9095616317594408056 where mi.movie_id=aggView9095616317594408056.v15 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German');
create or replace view aggView3397974523096344018 as select id as v3 from info_type as it;
create or replace view aggJoin3624868367931392507 as select v15, v13 from aggJoin119854284420516583 join aggView3397974523096344018 using(v3);
create or replace view aggView439521574805475110 as select v15 from aggJoin3624868367931392507 group by v15;
create or replace view aggJoin7268534364320005345 as select title as v16 from title as t, aggView439521574805475110 where t.id=aggView439521574805475110.v15 and production_year>2005;
select MIN(v16) as v27 from aggJoin7268534364320005345;
