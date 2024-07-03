create or replace view aggView5135248909674414171 as select id as v1 from company_name as cn where country_code= '[de]';
create or replace view aggJoin6837716415074978693 as select movie_id as v12 from movie_companies as mc, aggView5135248909674414171 where mc.company_id=aggView5135248909674414171.v1;
create or replace view aggView5035389715136918525 as select id as v12, title as v31 from title as t;
create or replace view aggJoin3131150320994116174 as select v12, v31 from aggJoin6837716415074978693 join aggView5035389715136918525 using(v12);
create or replace view aggView4606893539046043326 as select id as v18 from keyword as k where keyword= 'character-name-in-title';
create or replace view aggJoin1564501920084815530 as select movie_id as v12 from movie_keyword as mk, aggView4606893539046043326 where mk.keyword_id=aggView4606893539046043326.v18;
create or replace view aggView6422107244793181315 as select v12, MIN(v31) as v31 from aggJoin3131150320994116174 group by v12,v31;
create or replace view aggJoin8316970995885583990 as select v31 from aggJoin1564501920084815530 join aggView6422107244793181315 using(v12);
select MIN(v31) as v31 from aggJoin8316970995885583990;
