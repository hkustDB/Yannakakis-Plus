create or replace view aggView6718692730514219591 as select id as v1 from company_name as cn where country_code= '[us]';
create or replace view aggJoin2212751067049694520 as select movie_id as v12 from movie_companies as mc, aggView6718692730514219591 where mc.company_id=aggView6718692730514219591.v1;
create or replace view aggView4812936827183713213 as select v12 from aggJoin2212751067049694520 group by v12;
create or replace view aggJoin1412379635612303334 as select movie_id as v12, keyword_id as v18 from movie_keyword as mk, aggView4812936827183713213 where mk.movie_id=aggView4812936827183713213.v12;
create or replace view aggView5704634207097435597 as select id as v18 from keyword as k where keyword= 'character-name-in-title';
create or replace view aggJoin1129874037444275500 as select v12 from aggJoin1412379635612303334 join aggView5704634207097435597 using(v18);
create or replace view aggView8811831977355206043 as select v12 from aggJoin1129874037444275500 group by v12;
create or replace view aggJoin7749012217445755759 as select title as v20 from title as t, aggView8811831977355206043 where t.id=aggView8811831977355206043.v12;
select MIN(v20) as v31 from aggJoin7749012217445755759;
